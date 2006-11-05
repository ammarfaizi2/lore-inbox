Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWKEGCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWKEGCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 01:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWKEGCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 01:02:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:53039 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161098AbWKEGCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 01:02:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LJHiTpPa29w4sXTANA4P+rrV5R5UFPw9x3BwqjcoEbDJfPiU+d2H/iuZXUQek2GQYTrjBUm9fIfrg8ITpNsIgV5yy6PlzEzVN+lMzTQUFOAyTO0dmIKqRceoOfwUXG8BXDNMCMDgOSvS98qTmi6b2YPeVY+y0JUPNx1sMjvgAQ0=
Message-ID: <86802c440611042202l703de80i26931090f2809e74@mail.gmail.com>
Date: Sat, 4 Nov 2006 22:02:14 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 32/33] x86_64: Relocatable kernel support
Cc: "Andi Kleen" <ak@suse.de>, Horms <horms@verge.net.au>,
       "Jan Kratochvil" <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, "Magnus Damm" <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1vepbx4aj.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	 <11544302483667-git-send-email-ebiederm@xmission.com>
	 <p73d5bk1dat.fsf@verdi.suse.de>
	 <m1vepbx4aj.fsf@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: d4bb4f52c59ba897
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> I guess I could take this in some slightly smaller steps.
> But this does wind up with decompressor being 64bit code.

Sorry to bring out the old mail.

except reusing the uncompressor in 32bit, is there any reason that you
removed startup_32 for vmlinux but keep startup_32 for bzImage?

that will make vmlinux use 64bit boot loader only.

YH
