Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVCPJF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVCPJF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 04:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVCPJF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 04:05:27 -0500
Received: from ozlabs.org ([203.10.76.45]:15277 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262294AbVCPJFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:05:22 -0500
Subject: Re: dereferencing module-internal pointer in
	scripts/mod/file2alias.c
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050308070522.GA5435@isilmar.linta.de>
References: <20050308070522.GA5435@isilmar.linta.de>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 02:36:40 +1100
Message-Id: <1110814600.17013.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 08:05 +0100, Dominik Brodowski wrote:
> Hi,
> 
> Is there any feasible way to dereference a pointer inside
> __mod_*_device_table which points to a string? 

No, because we would basically need to perform relocations to do so.
That is why arrays are used in the current structures.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

