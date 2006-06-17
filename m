Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWFQEof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWFQEof (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 00:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWFQEof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 00:44:35 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:37185 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750814AbWFQEoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 00:44:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=eoS3GUvEkz3D/R8fzVRXVijLAEFe2/jmDXMzgnJ8+i3bBbDoGn7RS28orQ0jYq6gxSTTRGbFA99sH68D4+mjsW0+pZGnfjm8E8munq2NoWKAc/YDj0sdPP/+QWsotSmvYy5bH9djEpHQqi/lgNn3VJyP88IZ9noO6aYgXTTsEME=
Message-ID: <84144f020606162144tbd14081tdaae00a8e4af9c7f@mail.gmail.com>
Date: Sat, 17 Jun 2006 07:44:34 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [RFC/PATCH 2/2] slab: consolidate allocation paths
Cc: christoph@lameter.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606161304400.16488@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150355565.4633.8.camel@ubuntu>
	 <Pine.LNX.4.64.0606161304400.16488@schroedinger.engr.sgi.com>
X-Google-Sender-Auth: 0d6382825c8ee828
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jun 2006, Pekka Enberg wrote:
> > This patch consolidates the UMA and NUMA memory allocation paths in the
> > slab allocator. This is accomplished by making the UMA-path look like
> > we are on NUMA but always allocating from the current node.

On 6/16/06, Christoph Lameter <clameter@sgi.com> wrote:
> Which kernel does this apply to? Cannot find this in upstream nor in
> Andrews tree.

Applies on top of git head and 2.6.17-rc6 from www.kernel.org here.
Did you apply both patches?

                                                       Pekka
