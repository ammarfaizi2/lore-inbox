Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263524AbTDNQRC (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTDNQRC (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:17:02 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:6022 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP id S263524AbTDNQRC (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:17:02 -0400
Date: Mon, 14 Apr 2003 17:29:18 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein31.homenet
To: Andreas Dilger <adilger@clusterfs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: olarge -- force O_LARGEFILE on app binaries.
In-Reply-To: <20030414101959.E26054@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.44.0304141724130.3964-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Andreas Dilger wrote:
> I don't see how this helps you very much.  So now, instead of the kernel
> complaining with EFBIG and/or SIGXFSZ, your 32-bit size offset wraps in
> the application.

Good point, but, very _very_ luckily it does NOT happen in this case, i.e. 
with gs(1). I just verified every bit of output and it is correct both 
before and beyond the 2G boundary, all the way to 5.2G. But in general 
(i.e. for some other app) your comment is valid.

Regards
Tigran

