Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWHQIgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWHQIgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWHQIgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:36:40 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:63928 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932458AbWHQIgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:36:38 -0400
Message-ID: <44E429B3.7030607@s5r6.in-berlin.de>
Date: Thu, 17 Aug 2006 10:32:51 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Patrick McFarland <diablod3@gmail.com>
CC: Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL Violation?
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <200608170242.40969.diablod3@gmail.com>
In-Reply-To: <200608170242.40969.diablod3@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(LKML readers please apologize this more or less off-topic posting.)

Patrick McFarland wrote:
> They don't have to release source code for any module you wrote from scratch 
> themselves, but said modules cannot say they are GPL (ie, they have to poison 
> the kernel).
> 
> Also, said kernel modules have to be real modules and not statically linked 
> into the kernel, and said modules have to have the compiled component objects 
> (ie, *.o) available so people can relink them into new modules to work with 
> new kernels.

I never heard that static vs. dynamic linking mattered WRT licensing, at
least if the unmodified GPL is involved. If a driver author doesn't want
to publish under the terms of GPL, an implementation in userspace may
make it possible to avoid linking with GPL code. But in the end, as has
been said multiple times: Consult a lawyer for such questions.

Here are a few pointers to the opinion of FSF as published in their FAQ.
(I doubt that the organization FSF is among the copyright holders of
Linux, but the FSF is copyright holder of the GPL and authors of GPL run
FSF. Therefore the FSF's statements are certainly relevant for you to
consider.)

About so-called modules, or "mere aggregation" versus "combining two
modules into one program" (highly relevant to Linux drivers):
http://www.fsf.org/licensing/licenses/gpl-faq.html#MereAggregation

About so-called libraries (a lot of parts of Linux are libraries or are
very similar to libraries):
http://www.fsf.org/licensing/licenses/gpl-faq.html#IfLibraryIsGPL

About so-called plugins (hardly relevant for kernel drivers):
http://www.fsf.org/licensing/licenses/gpl-faq.html#GPLAndPlugins

-- 
Stefan Richter
-=====-=-==- =--- =---=
http://arcgraph.de/sr/
