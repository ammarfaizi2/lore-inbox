Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbTDOUzG (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 16:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTDOUzG 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 16:55:06 -0400
Received: from holomorphy.com ([66.224.33.161]:48263 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262964AbTDOUzF 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 16:55:05 -0400
Date: Tue, 15 Apr 2003 14:06:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.66-mm3 -  bad ext2 performance ?
Message-ID: <20030415210624.GH706@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
References: <200304151356.24323.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304151356.24323.pbadari@us.ibm.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 02:00:05PM -0700, Badari Pulavarty wrote:
> This is kind of extreem. But  I have 1070 LUNS and I mkfs/mounted (ext2) all
> these and running "fsx" on all of them. 
> I see very bad IO rate on the machine.  fsx with O_DIRECT seems to be
> doing okay. Any ideas on why regular filesystem (buffered) IO sucks ?
> I dont' see even cache increasing ..

Can we get a "before" profile on the same machine to compare against?


-- wli
