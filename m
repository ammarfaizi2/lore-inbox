Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTIIUoB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTIIUoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:44:00 -0400
Received: from lidskialf.net ([62.3.233.115]:63705 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S264379AbTIIUn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:43:59 -0400
From: Andrew de Quincey <adq@lidskialf.net>
To: jbarnes@sgi.com (Jesse Barnes), andrew.grover@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Date: Tue, 9 Sep 2003 21:43:58 +0100
User-Agent: KMail/1.5.3
References: <20030909201310.GB6949@sgi.com>
In-Reply-To: <20030909201310.GB6949@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309092143.58189.adq@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 September 2003 21:13, Jesse Barnes wrote:
> Instead of going into an infinite loop because the list isn't setup yet,
> just return NULL if there are no prt entries.

Ah, this is a patch against the vanilla kernel.. This is unfortunately 
incompatible with my recent ACPI patches.

