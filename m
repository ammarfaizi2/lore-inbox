Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUELGML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUELGML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 02:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbUELGML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 02:12:11 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:51502
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S264991AbUELGMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 02:12:08 -0400
thread-index: AcQ36H3Sk9+cQm9FQmu9h5iCd+6BGw==
X-Sieve: Server Sieve 2.2
Date: Wed, 12 May 2004 07:15:15 +0100
From: "Christoph Hellwig" <hch@infradead.org>
To: <Administrator@vger.kernel.org>
Cc: <akpm@osdl.org>, <benh@kernel.crashing.org>,
       <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Message-ID: <000001c437e8$7de0a070$d100000a@sbs2003.local>
Subject: Re: [PATCH 1/2] PPC32: New OCP core support
Content-Transfer-Encoding: 7bit
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,Matt Porter <mporter@kernel.crashing.org>, akpm@osdl.org,benh@kernel.crashing.org, linux-kernel@vger.kernel.org,linuxppc-dev@lists.linuxppc.org
References: <20040511170150.A4743@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
X-Mailer: Microsoft CDO for Exchange 2000
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040511170150.A4743@home.com>; from mporter@kernel.crashing.org on Tue, May 11, 2004 at 05:01:50PM -0700
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-me-spamlevel: not-spam
Content-Class: urn:content-classes:message
Importance: normal
X-me-spamrating: 3.125262
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
X-OriginalArrivalTime: 12 May 2004 06:15:15.0921 (UTC) FILETIME=[7E01E410:01C437E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, May 11, 2004 at 05:01:50PM -0700, Matt Porter wrote:
> New OCP infrastructure ported from 2.4 along with several
> enhancements. Please apply.

The old-style PM callback (using struct pm_dev) is bogus, please kill
that part.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


