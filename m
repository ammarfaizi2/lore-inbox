Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbTFER64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbTFER64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:58:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264780AbTFER6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:58:55 -0400
Date: Thu, 5 Jun 2003 11:12:12 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: jjs <jjs@tmsusa.com>, James Morris <jmorris@intercode.com.au>,
       Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 latest: breaks gnome
Message-Id: <20030605111212.33e63d46.shemminger@osdl.org>
In-Reply-To: <3EDE7398.70005@tmsusa.com>
References: <20030604142241.0dc6f34e.shemminger@osdl.org>
	<3EDE7398.70005@tmsusa.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jun 2003 15:32:56 -0700
jjs <jjs@tmsusa.com> wrote:

> Yes, same here but running 2.5.70-mm4
> 
> gnome gdm won't start - so it looks like a
> bug introduced in -bk-recent
> 
> Joe
> 
> Stephen Hemminger wrote:
> 
> >On my machine, the current 2.5.70 bk tree has a serious problem.
> >Using RH8.0 it will not complete the normal user graphical login.
> >Machine is alive, and can access it via console and other non-graphical login.
> >
> >One of the gnome processes or ssh-agent gets hung?


This got fixed with last night's changes.  I assume it was related to the net/core/iovec.c fix.
