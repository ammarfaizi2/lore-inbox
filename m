Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278085AbRJPEl1>; Tue, 16 Oct 2001 00:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278087AbRJPElS>; Tue, 16 Oct 2001 00:41:18 -0400
Received: from zok.sgi.com ([204.94.215.101]:31907 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278085AbRJPElK>;
	Tue, 16 Oct 2001 00:41:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: christophe barbe <christophe.barbe.ml@online.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export pci_table in aic7xxx for Hotplug 
In-Reply-To: Your message of "Mon, 15 Oct 2001 14:31:47 CST."
             <200110152031.f9FKVlY56104@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 14:41:34 +1000
Message-ID: <20015.1003207294@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 14:31:47 -0600, 
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>>I have defined __NO_VERSION__ before including module.h because in my
>>understanding this is required when you include it in a multi-files module.
>>Only one file must include module.h without defining the __NO_VERSION__.
>
>I can find no reference to "__NO_VERSION__" in module.h or the files
>it includes.   Perhaps this is a requirement for old kernels?

__NO_VERSION__ used to be required in multi part modules but too many
people got it wrong so I removed it in 2.3 kernels, fixing the problem
in a diffrent way.  Removing all defines of __NO_VERSION__ is on my
clean up list for 2.5.

