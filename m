Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWEZUaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWEZUaM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 16:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWEZUaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 16:30:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30699 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751461AbWEZUaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 16:30:10 -0400
Date: Fri, 26 May 2006 21:30:03 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Evan Harris <eharris@puremagic.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ext3-fs transient corruption with devmapper over md raid, kernel 2.6.16.14
Message-ID: <20060526203003.GC10603@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Evan Harris <eharris@puremagic.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0605231225450.11814@kinison.puremagic.com> <20060523221547.GA1002@agk.surrey.redhat.com> <Pine.LNX.4.62.0605261425160.19083@kinison.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0605261425160.19083@kinison.puremagic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 02:35:48PM -0500, Evan Harris wrote:
> However, this leads me to suspect that the problem is either in dm-crypt, 
> or a data corruption problem resulting from a decrypt error from the 
> aes_x86_64 module that dm-crypt is using.
 
Perhaps try a different crypt module too?

Alasdair
-- 
agk@redhat.com
