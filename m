Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTGCMf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTGCMf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:35:28 -0400
Received: from angband.namesys.com ([212.16.7.85]:2432 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262095AbTGCMfW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:35:22 -0400
Date: Thu, 3 Jul 2003 16:49:47 +0400
From: Oleg Drokin <green@namesys.com>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: high system usage with kmail in 2.5.7X
Message-ID: <20030703124947.GA819@namesys.com>
References: <200307031637.46227.rathamahata@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307031637.46227.rathamahata@php4.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jul 03, 2003 at 04:37:46PM +0400, Sergey S. Kostyliov wrote:

> I experienced an abnormally high system usage whith kmail
> (KDE mail client). This is usually happened when I click on a
> huge mail folder. Then kmail just stops responding for a dozens of seconds.
> Seems like problem started around 2.5.70 (2.5.69 doesn't compile on my box,
> 2.5.68 works fine for me).

This is a kmail 3.0x problem (with large recommended i/o sizes), it is reported that upgrading to kmail 3.1+ will help.
Alternatively you can mount your reiserfs volumes with "-o nolargeio=1"

Bye,
    Oleg
