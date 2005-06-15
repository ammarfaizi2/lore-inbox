Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVFOUQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVFOUQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVFOUQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:16:10 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:57515 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261534AbVFOUQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:16:04 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Gr?goire Favre <gregoire.favre@gmail.com>, dino@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050615200957.GA23096@janus>
References: <1118590709.4967.6.camel@mulgrave>
	 <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave>
	 <20050613183719.GA8653@gmail.com> <1118695847.5079.41.camel@mulgrave>
	 <20050613214208.GA7471@janus> <1118703593.5079.56.camel@mulgrave>
	 <20050614214226.GA15560@janus> <20050615120237.GB19645@janus>
	 <1118844888.5045.18.camel@mulgrave>  <20050615200957.GA23096@janus>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 15:15:46 -0500
Message-Id: <1118866546.5045.76.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 22:09 +0200, Frank van Maarseveen wrote:
>         User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
>         Goal: 10.000MB/s transfers (10.000MHz, offset 15)
>         Curr: 10.000MB/s transfers (10.000MHz, offset 15)

This would be why ... you need to set you bios to 10MHz narrow (it's
currently set to 40MHz wide).

James


