Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S271335AbUJVPVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271335AbUJVPVr (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 22 Oct 2004 11:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271331AbUJVPVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:21:47 -0400
Received: from ee.oulu.fi ([130.231.61.23]:48778 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S271361AbUJVPU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:20:27 -0400
Date: Fri, 22 Oct 2004 18:19:43 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Onur Kucuk <onur@delipenguen.net>, Olivier Galibert <galibert@pobox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Buggy DSDTs policy ?
Message-ID: <20041022151943.GA16874@ee.oulu.fi>
References: <20041022122326.GA69381@dspnet.fr.eu.org> <20041022174154.2ebd2c5c.onur@delipenguen.net> <1098456935.31003.77.camel@gonzales>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1098456935.31003.77.camel@gonzales>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 04:55:35PM +0200, Xavier Bestel wrote:
> >  CONFIG_ACPI_CUSTOM_DSDT is included in 2.6.9
> 
> But fixed DSDTs are a pain to find, and fixing a buggy DSDT is
> impossible for a non-hacker.
> 
http://acpi.sourceforge.net/dsdt/index.php has quite a few.

The problem is getting the fixed dsdt in use without recompiling your
kernel, since quite a few people, especially non-technical ones, use vendor
kernels. There's an approach that uses initrd, but this isn't merged
yet. I'd say it should be, assuming no better solution can be found.

