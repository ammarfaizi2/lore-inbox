Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUHPRkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUHPRkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267820AbUHPRkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:40:15 -0400
Received: from main.gmane.org ([80.91.224.249]:32232 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267818AbUHPRkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:40:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Jones <adam@yggdrasl.demon.co.uk>
Subject: Re: growisofs stopped working with 2.6.8
Date: Mon, 16 Aug 2004 18:28:37 +0100
Message-ID: <5f77v1-cei.ln1@yggdrasl.demon.co.uk>
References: <1092674287.3021.19.camel@bony>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: yggdrasl.demon.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a futile gesture against entropy, Tony A. Lambley wrote:
> Hi, burning a dvd iso now fails :(
> 
> $ growisofs -Z /dev/hdc=file.iso
> :-( unable to GET CONFIGURATION: Operation not permitted
> :-( non-MMC unit?

In case it's helpful, when running growisofs setuid from a normal user
account (with write access to the device node), the error is:

:-( unable to PREVENT MEDIA REMOVAL: Operation not permitted

Should locking the drive door be allowed for normal users?
-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
.oO("what's big iron?"                                                 )
PGP public key: http://www.yggdrasl.demon.co.uk/pubkey.asc

