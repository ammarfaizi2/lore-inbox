Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUBIQzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbUBIQzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:55:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63368 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264949AbUBIQzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:55:01 -0500
Date: Mon, 9 Feb 2004 11:54:53 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: 2.6.3-rc1-mm1
In-Reply-To: <20040209014035.251b26d1.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0402091153210.2328-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, Andrew Morton wrote:

> +highmem-equals-user-friendliness.patch
> 
>  Enhance and document the `highmem=' ia32 kernel boot option.  This also
>  gives us highmem emulation on <= 896M boxes.

This seems to be breaking initrd when highmem is enabled:

  initrd extends beyond end of memory (0x37feffc9 > 0x30400000)
  disabling initrd


- James
-- 
James Morris
<jmorris@redhat.com>


