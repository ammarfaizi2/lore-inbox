Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbREVQ3O>; Tue, 22 May 2001 12:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262618AbREVQ3F>; Tue, 22 May 2001 12:29:05 -0400
Received: from sisley.ri.silicomp.fr ([62.160.165.44]:39435 "EHLO
	sisley.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S262617AbREVQ2v>; Tue, 22 May 2001 12:28:51 -0400
Date: Tue, 22 May 2001 18:28:33 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: <linux-kernel@vger.kernel.org>
cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
Subject: [Q] [VFS] i_mapping vs. i_data ?
Message-ID: <Pine.LNX.4.31.0105221813030.29327-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have the following question for VFS gurus here:

In the inode struct, an address_space (i_data) and a pointer to an
address_space (i_mapping) are defined, and it looks like i_mapping is
always a reference to the inode's i_data (except in coda_open). Then what
is the difference of meaning between these two ?


Regards,

-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:saffroy@ri.silicomp.fr

