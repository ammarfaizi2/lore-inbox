Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753190AbWKCJNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbWKCJNJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 04:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbWKCJNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 04:13:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:51288 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753190AbWKCJNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 04:13:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fOrpoLRiBz4sVNaYpZwDRoznlMJ+XyIXDu1iVE+XbVZ5H6oljZkHst3BvFblmdyptFwObhx5s4/JHWzPHQfHD5xLwgMDFW7vYBPnmtb+yI+nCtuhGVb0eDiQeCIeQQgKum87NJgK7ecDdhAAfWWGZ7N9q/g5yvbIScrGsR0rKM4=
Message-ID: <84144f020611030113u119a3759q11a3ac4cfacccb74@mail.gmail.com>
Date: Fri, 3 Nov 2006 11:13:04 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH 2/3] fsstack: Generic get/set lower object functions
Cc: "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>,
       "Mark Williamson" <mark.williamson@cl.cam.ac.uk>,
       linux-kernel@vger.kernel.org, "Michael Halcrow" <mhalcrow@us.ibm.com>,
       "Erez Zadok" <ezk@cs.sunysb.edu>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Al Viro" <viro@ftp.linux.org.uk>, "Andrew Morton" <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1162535103.5635.20.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu>
	 <1162483565.6299.98.camel@lade.trondhjem.org>
	 <20061103032702.GB13499@filer.fsl.cs.sunysb.edu>
	 <200611030345.51167.mark.williamson@cl.cam.ac.uk>
	 <20061103035130.GC13499@filer.fsl.cs.sunysb.edu>
	 <1162535103.5635.20.camel@lade.trondhjem.org>
X-Google-Sender-Auth: 71feea93d0d86025
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> Why? What is so special about the details that you need to hide them?
> This is a union that will always be part of a structure anyway.

Nothing. Josef, I think we should make them unions.
