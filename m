Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWG0TWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWG0TWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWG0TWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:22:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:45291 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751027AbWG0TWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:22:20 -0400
In-Reply-To: <b0943d9e0607270200h250953d7uf58dc9a4f087cb0b@mail.gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Cc: "Catherine Zhang" <cxzhang@watson.ibm.com>, czhang.us@gmail.com,
       davem@davemloft.net, jmorris@namei.org, linux-kernel@vger.kernel.org,
       michal.k.k.piotrowski@gmail.com, netdev@vger.kernel.org,
       sds@tycho.nsa.gov
Subject: Re: RFC: kernel memory leak fix for af_unix datagram getpeersec
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OF4EC0606D.E357EE61-ON852571B8.006A5AAE-852571B8.006A68C9@us.ibm.com>
From: Xiaolan Zhang <cxzhang@us.ibm.com>
Date: Thu, 27 Jul 2006 15:22:16 -0400
X-MIMETrack: Serialize by Router on D01ML605/01/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 07/27/2006 15:22:18,
	Serialize complete at 07/27/2006 15:22:18
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Catalin and Michal,

Many thanks for your help in fnding and testing the patch!

Catherine

"Catalin Marinas" <catalin.marinas@gmail.com> wrote on 07/27/2006 05:00:23 
AM:

> On 26/07/06, Catherine Zhang <cxzhang@watson.ibm.com> wrote:
> > Enclosed please find the new fix for the memory leak problem, 
incorporating
> > suggestions from Stephen and James.
> 
> FYI, Michal confirmed that, with this patch, kmemleak no longer
> reports leaks in the context_struct_to_string() function in
> security/selinux/ss/services.c. Many thanks to Michal for testing this
> (and his constant feedback into kmemleak).
> 
> -- 
> Catalin

