Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVCBXDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVCBXDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVCBXDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:03:16 -0500
Received: from main.gmane.org ([80.91.229.2]:50134 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261161AbVCBXAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:00:53 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Date: Wed, 02 Mar 2005 23:57:46 +0100
Message-ID: <d05g45$pos$1@sea.gmane.org>
References: <20050228231721.GA1326@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 195.70.138.133
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
In-Reply-To: <20050228231721.GA1326@elf.ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> In `subj` kernel, machine no longer powers down at the end of
> swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.

For me, power down stopped working since the introduction of softlockup 
detection. After disabling CONFIG_DETECT_SOFTLOCKUP, powerdown works fine.

-- 
Jindrich Makovicka

