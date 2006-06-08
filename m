Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWFHS1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWFHS1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWFHS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:27:52 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:35508 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964876AbWFHS1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:27:51 -0400
Subject: Re: 2.6.17-rc6, bcm43xx and WPA
From: Andreas Rittershofer <andreas@rittershofer.de>
Reply-To: andreas@rittershofer.de
To: linux-kernel@vger.kernel.org
In-Reply-To: <44885835.9060403@gentoo.org>
References: <1149762392.3781.7.camel@coredump> <44885835.9060403@gentoo.org>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 20:27:27 +0200
Message-Id: <1149791247.3781.23.camel@coredump>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-ID: VgDi48ZvQebs9ZUS-YlQmyE7umDLJn5+Dtxq8iTYZic3Nv32UGaP60@t-dialin.net
X-TOI-MSGID: dcbf0b45-d30f-4825-b276-b712f3af5322
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 08.06.2006, 18:02 +0100 schrieb Daniel Drake:
> Andreas Rittershofer wrote:
> > Authentication to my AP is not possible, the problem seems to be:
> > 
> > ioctl[SIOCSIWENCODEEXT]: Invalid argument
> > Driver did not support SIOCSIWENCODEEXT
> > WPA: Failed to set PTK to the driver.
> 
> Looks like you didn't compile the relevant software encryption support 
> into your kernel.
> 

Do you mean the following:

CONFIG_IEEE80211_CRYPT_CCMP= m
CONFIG_IEEE80211_CRYPT_TKIP= m
CONFIG_IEEE80211_CRYPT_SOFTMAC= m

These are made as modules.

mfg ar
-- 
E-Learning in der Schule:
http://www.dbg-metzingen.de/Menschen/Lehrer/Q-T/Rittershofer/E-Learning/

