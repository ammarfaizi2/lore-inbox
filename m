Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSEUIiQ>; Tue, 21 May 2002 04:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSEUIiQ>; Tue, 21 May 2002 04:38:16 -0400
Received: from imladris.infradead.org ([194.205.184.45]:46345 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316571AbSEUIiO>; Tue, 21 May 2002 04:38:14 -0400
Date: Tue, 21 May 2002 09:38:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.17: hfs no go
Message-ID: <20020521093807.B6641@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	A Guy Called Tyketto <tyketto@wizard.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020521063205.GA16131@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 11:32:05PM -0700, A Guy Called Tyketto wrote:
> 
>         subject sez it all:

You might want to add a 

#include <linux/pagemap.h>

to fs/hfs/inode.c

