Return-Path: <linux-kernel-owner+w=401wt.eu-S1751308AbXAUSfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXAUSfJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 13:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbXAUSfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 13:35:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:57139 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbXAUSfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 13:35:07 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tfEExI0PRQMQtBYShJDZh7prf4xONUKZcZjajFdWehtr4e3Ez3+gB34nZWXE0dGRtUOWsae0gwARvcBhQjNcrvgedtL7B6Opod3PnQmBasQbuBye8YjfkVCC8S1UPa7OsjndSZ0qwIVpiOoPP8DLf77REVoJDei2Up3M8X4ZH6E=
From: Ivan Ukhov <uvsoft@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How to use an usb interface than is claimed by HID?
Date: Sun, 21 Jan 2007 21:34:58 +0300
User-Agent: KMail/1.9.5
References: <45B265E0.5020605@gmail.com> <Pine.LNX.4.64.0701211358570.21127@twin.jikos.cz> <Pine.LNX.4.64.0701211821530.21127@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0701211821530.21127@twin.jikos.cz>
Cc: UVSoft@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701212134.58646.uvsoft@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> .. which wouldn't help you either, supposing that you don't want to touch
> the kernel sources at all, because this function is unexported and static.
>
> So I think that there is no straightforward way, sorry.
>
> Is this a device that doesn't exist anywhere else than on your table? I
> still think that putting the code in kernel (if possible) and blacklisting
> the device on the hid_blacklist[] is the simplest way.
>
> The other possibility is writing the driver completely in userspace, using
> libhid/hiddev. Would that suit your needs?

I'm afraid it wouldn't.

Thank you very much.

-- 
Regards,
Ivan Ukhov.
