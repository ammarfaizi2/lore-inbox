Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRKMSEd>; Tue, 13 Nov 2001 13:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277738AbRKMSEN>; Tue, 13 Nov 2001 13:04:13 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:25024 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277722AbRKMSEH>;
	Tue, 13 Nov 2001 13:04:07 -0500
Date: Tue, 13 Nov 2001 18:04:00 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Tommy Reynolds <reynolds@redhat.com>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Changed message for GPLONLY symbols
Message-ID: <2352746460.1005674640@[10.132.113.67]>
In-Reply-To: <20011113113401.55b75a1b.reynolds@redhat.com>
In-Reply-To: <20011113113401.55b75a1b.reynolds@redhat.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, November 13, 2001 11:34 AM -0600 Tommy Reynolds 
<reynolds@redhat.com> wrote:

> In either case, contact
>>       the *only* module supplier for assistance; no one else can help
>>       you.

Well they might be able to help themselves by recompiling (for
instance a BSD with advertising module) - this happens for
instance when functions become #define's and so forth - so
if you want full detail, at risk of #include <warandpeace.h>:

For modules without a GPL license:

 You are trying to load a module which has unresolved symbols. These
 symbols may not be exported by this version of the kernel (perhaps
 you have a version mismatch), or they may be exported GPLONLY,
 (in which case they will not be available to your module which does
 not carry a GPL compatible license). You may be able to fix
 this by recompiling the module against your current kernel's source;
 if this doesn't work, or you don't have module source code,
 contact *only* the module supplier for assistance; no one else
 can help you.

And the alternative version if the module DOES have a GPL license:

 You are trying to load a GPL licensed module which has unresolved
 symbols. These symbols may not be exported by this version of the
 kernel (perhaps you have a version mismatch). You may be able to fix
 this by obtaining the source code for the module, and recompiling it
 against your current kernel's source.

--
Alex Bligh
