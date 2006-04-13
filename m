Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWDMTxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWDMTxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 15:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWDMTxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 15:53:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35784 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964958AbWDMTxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 15:53:17 -0400
Date: Thu, 13 Apr 2006 12:53:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kexec: Remove order
In-Reply-To: <m164le6rcg.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0604131252110.14044@schroedinger.engr.sgi.com>
References: <20060413030040.20516.9231.sendpatchset@cherry.local>
 <m164le6rcg.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2006, Eric W. Biederman wrote:

> Until I see a reasonable argument that none of the architectures
> currently supported by the linux kernel would need a multi order
> allocation for a kexec port am I interested in removing support.

IA64 needs an order 1 allocation for stack / task_struct.

