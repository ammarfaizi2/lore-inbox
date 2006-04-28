Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWD1Gcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWD1Gcl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWD1Gcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:32:41 -0400
Received: from wproxy.gmail.com ([64.233.184.224]:27102 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030273AbWD1Gck convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:32:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kviRnJ4GdSzpjUcnOyvy533ccR3FOt0slnul3cVjFlTKuvT41XuSAyjWq0BuL+zvbVotw5y6KHweY84V+qqcqznovJx2wdX5xMwBqz+EZkxqs/sT5guVRGtGZNAfPqCRgZ2Rui5vr835SRkNO5XyNBQAYRPUBphUZT1q3YaTxHU=
Message-ID: <84144f020604272332s6101032cy6936096230f3637c@mail.gmail.com>
Date: Fri, 28 Apr 2006 09:32:40 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Heiko J Schick" <info@schihei.de>
Subject: Re: [openib-general] Re: [PATCH 04/16] ehca: userspace support
Cc: "Michael Ellerman" <michael@ellerman.id.au>,
       "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       linuxppc-dev@ozlabs.org, "Christoph Raisch" <RAISCH@de.ibm.com>,
       "Hoang-Nam Nguyen" <HNGUYEN@de.ibm.com>,
       "Marcus Eder" <MEDER@de.ibm.com>
In-Reply-To: <6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4450A176.9000008@de.ibm.com>
	 <20060427114355.GB32127@wohnheim.fh-wedel.de>
	 <1146177388.19236.1.camel@localhost.localdomain>
	 <6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 4/28/06, Heiko J Schick <info@schihei.de> wrote:
> The problem I see with pr_debug() is that it could only activated via
> a compile flag. To use the debug outputs you have to re-compile /
> compile your own kernel.

Do you really need this heavy debug logging in the first place? You
can use kprobes for arbitrary run-time inspection anyway, so logging
everything seems wasteful.

                                             Pekka
