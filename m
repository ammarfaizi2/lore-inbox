Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310257AbSCBBzT>; Fri, 1 Mar 2002 20:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310258AbSCBBzK>; Fri, 1 Mar 2002 20:55:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55254 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310257AbSCBByx>;
	Fri, 1 Mar 2002 20:54:53 -0500
Date: Fri, 1 Mar 2002 20:54:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Thomas Hood <jdthood@mail.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: How to get kernel data using /proc system?
In-Reply-To: <1015026435.2121.198.camel@thanatos>
Message-ID: <Pine.GSO.4.21.0203012043250.4597-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 Mar 2002, Thomas Hood wrote:

> I wrote the following comment block explaining how 
> to write a proc_file_read function.  This is the 
> function you register with procfs using 
> create_proc_read_entry().  Hope this helps. 

[snip ~50 lines of comments]

You know, that's a wonderful explanation... of reasons for _not_ using
->proc_read().  If interface takes that much to document - it's crap.

