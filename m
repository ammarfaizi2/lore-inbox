Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUKRVzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUKRVzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUKRVwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:52:31 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:13263 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263036AbUKRVuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:50:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cFldHU5whSTDOxkBNJZLEMhILm+BhgcKvpUeFmacvifHnW/m6Um0ajDZ6pJOiQVeQakshsGyelY/GVCJUTDwoX+ruLITg196yWy1nUmhRugbheTzkSkqZv0jcg6XJM04aGzWAyWs7+GLF/tTC/1SRw4iW1iWqTDc0v9mK5++s2A=
Message-ID: <aec7e5c3041118134969dfab53@mail.gmail.com>
Date: Thu, 18 Nov 2004 22:49:58 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Dave Jones <davej@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: e820 and shared VGA memory problem
In-Reply-To: <20041118214431.GC1347@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <aec7e5c304111813202f74a139@mail.gmail.com>
	 <20041118214431.GC1347@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 16:44:31 -0500, Dave Jones <davej@redhat.com> wrote:
> In the past such problems have been attributed to BIOS's not
> setting up MTRRs correctly, or in extreme situations, running
> out of available MTRRS.  How does /proc/mtrr look ?

reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x40000000 (1024MB), size= 512MB: write-back, count=1
reg02: base=0x60000000 (1536MB), size= 256MB: write-back, count=1
reg03: base=0x70000000 (1792MB), size= 128MB: write-back, count=1
reg04: base=0x78000000 (1920MB), size=  64MB: write-back, count=1
reg05: base=0x7c000000 (1984MB), size=  32MB: write-back, count=1
reg06: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1

Thanks!

/ magnus
