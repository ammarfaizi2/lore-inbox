Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751987AbWFWUjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbWFWUjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWFWUjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:39:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:55991 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751987AbWFWUjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:39:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c8aBc4xcZ1kMe6MVdgFZ3Dq4Tf2t+8SnPxbCsrnBZnr/nnrLOmBCMz4Qv/k2V2aebViVTaKc1NjJUpY9FFOC+zH/LfckyoDfIni66gbwjvl8+6oBwKW9qVP4q20X//KnN14J+5SAd2h32KQ+GFTamiUX0yodnQ6TNpMHtJAJVHU=
Message-ID: <a762e240606231339n11b8de89r37b9ff0401c50e21@mail.gmail.com>
Date: Fri, 23 Jun 2006 13:39:01 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060621034857.35cfe36f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
  When I make mrproper to clean the kernel tree with the -mm trees (at
least the last few releases) I end up having to remove
/include/linux/dwarf2-defs.h myself.  This file is generated at build
time but mrproper isn't cleaning it up.   This file is always present
in a tree that has been built but not in the origninal tree so a diff
of the tree picks it up.

Is this expected?

Thanks,
  Keith
