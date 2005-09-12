Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVILTIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVILTIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVILTIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:08:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:977 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932154AbVILTIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:08:54 -0400
Subject: Re: [RFC][PATCH 1/2] i386: consolidate discontig functions into
	normal ones
From: Dave Hansen <haveblue@us.ibm.com>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <4325D150.6040505@kolumbus.fi>
References: <20050912175319.7C51CF96@kernel.beaverton.ibm.com>
	 <4325D150.6040505@kolumbus.fi>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 12 Sep 2005 12:08:41 -0700
Message-Id: <1126552121.5892.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 22:04 +0300, Mika Penttilä wrote:
> I think you allocate remap pages for nothing in the flatmem case for 
> node0...those aren't used for the mem map in !NUMA.

I believe that is fixed up in the second patch.  It should compile a
do{}while(0) version instead of doing a real call.  

-- Dave

