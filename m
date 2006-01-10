Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWAJKuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWAJKuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAJKuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:50:16 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:53219 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932155AbWAJKuN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:50:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f5UpGGHPOauUgUySWRV7bpUY4kT3fa2cZJVV/ZOQ4U764EkfHiSH8H+sPweBYmqsFenQQtAzIop7gOF8kOIyudzs5slRpStAgP5lu9VCXtxggOJ8HgTd2ZNJg15TsowH48gIEUkuC/BL+BtkKkOWFK7bTwvusD94BZKPm9X24P4=
Message-ID: <f0309ff0601100250p55bc635aw98fcd55b327e2392@mail.gmail.com>
Date: Tue, 10 Jan 2006 02:50:12 -0800
From: Nauman Tahir <nauman.tahir@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: X86_64 and X86_32 bit performance difference [Revisited]
Cc: kernelnewbies@nl.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <p734q4dxnnb.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f0309ff0601082229u3fc5e415m12be9dc921f4a099@mail.gmail.com>
	 <p734q4dxnnb.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Jan 2006 19:27:20 +0100, Andi Kleen <ak@suse.de> wrote:
> Nauman Tahir <nauman.tahir@gmail.com> writes:
>
> > I have posted this problem before. Now mailing again after testing as
> > recommeded in previous replys.
> > My configuration is:
>
> Most likely it's related to you misusing the PCI DMA API in some way.
> Review Documentation/DMA-mapping.txt closely.
>
> If that doesn't turn on the light try oprofile.

what is oprofile???
>
> -Andi
>
