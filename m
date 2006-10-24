Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWJXVcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWJXVcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWJXVcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:32:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:26414 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161228AbWJXVcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:32:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NKB9dW05fNAVqmDE/ZjWcgaSlUBjaZcxNbPgbXQ9RCXlGamWEFr96AqukX85E6hZqvF2SEGlPVWYcAQshSB2M2rgwR00qoVHw48nAV7gH4rrBWbntKPVAHcN30pNytAJDBDdbVnrgMixr/y9YHt9oOe9c25xcIvdLfx/VrZXXqU=
Message-ID: <21d7e9970610241431j38c59ec5rac17f780813e6f05@mail.gmail.com>
Date: Tue, 24 Oct 2006 14:31:41 -0700
From: "Dave Airlie" <airlied@gmail.com>
To: "Nick Piggin" <npiggin@suse.de>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Cc: "Linux Memory Management" <linux-mm@kvack.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061007105853.14024.95383.sendpatchset@linux.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061007105758.14024.70048.sendpatchset@linux.site>
	 <20061007105853.14024.95383.sendpatchset@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/06, Nick Piggin <npiggin@suse.de> wrote:
> Nonlinear mappings are (AFAIKS) simply a virtual memory concept that
> encodes the virtual address -> file offset differently from linear
> mappings.
>

Hi Nick,

what is the status of this patch? I'm just trying to line up a kernel
tree for the new DRM memory management code, which really would like
this...

Dave.
