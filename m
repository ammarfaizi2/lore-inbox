Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268517AbUHLLzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268517AbUHLLzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 07:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268518AbUHLLzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 07:55:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45969 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268517AbUHLLzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 07:55:51 -0400
Date: Thu, 12 Aug 2004 12:55:51 +0100
From: Matthew Wilcox <willy@debian.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: Altix I/O code reorganization - 11 of 21
Message-ID: <20040812115551.GO5387@parcelfarce.linux.theplanet.co.uk>
References: <200408112331.i7BNVsWk140739@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408112331.i7BNVsWk140739@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 06:31:54PM -0500, Pat Gefre wrote:
> +# Makefile for the sn2 io routines.
> +
> +obj-y				:=  klconflib.o

I agree with Christoph.  It's ridiculous to have one file per directory
like this.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
