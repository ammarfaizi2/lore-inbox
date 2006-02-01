Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422955AbWBAVpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422955AbWBAVpU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422958AbWBAVpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:45:20 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:51250 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422955AbWBAVpT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:45:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XFFzGIDKMSXpMgaPs8pCUxB8PcHlc+aNLySpDUuoowuYjhKYt2c5/He/Dd2Oqnxoi4p0/niSfp7mW6AGXXKf75fy1lBRJ+dhBfolnE0Agd0YaxV5NgfjKzXhAFbUy6FHjFLpop4ebLkv8L9l7wsqFJh3tOYDrrMhl7IuZDdf/4U=
Message-ID: <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com>
Date: Wed, 1 Feb 2006 23:45:15 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200602020730.16916.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602012245.06328.nigel@suspend2.net>
	 <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com>
	 <200602020730.16916.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 23:01, Pekka Enberg wrote:
> > I think we can call these suspend_{get|set}_modules instead i.e.
> > without the extra '2'.

On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> I wanted to avoid confusion with similar routine names Pavel might use. For
> example, he has a resume_setup and I have a resume2_setup.

Is that necessary for the mainline, though? We have only one suspend
in the kernel, not "Pavel suspend" and "Nigel suspend", right?

                                        Pekka
