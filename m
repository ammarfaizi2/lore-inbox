Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWC2Uav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWC2Uav (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 15:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWC2Uau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 15:30:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:63204 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750816AbWC2Uau
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 15:30:50 -0500
Subject: Re: [RFC] Virtualization steps
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       devel@openvz.org, serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
In-Reply-To: <4428F902.1020706@sw.ru>
References: <44242A3F.1010307@sw.ru>
	 <20060324211917.GB22308@MAIL.13thfloor.at>
	 <m1psk7enfm.fsf@ebiederm.dsl.xmission.com>  <4428F902.1020706@sw.ru>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 12:30:34 -0800
Message-Id: <1143664234.9731.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 12:51 +0400, Kirill Korotaev wrote:
> Eric, we have a GIT repo on openvz.org already:
> http://git.openvz.org 

Git is great for getting patches and lots of updates out, but I'm not
sure it is idea for what we're trying to do.  We'll need things reviewed
at each step, especially because we're going to be touching so much
common code.

I'd guess set of quilt (or patch-utils) patches is probably best,
especially if we're trying to get stuff into -mm first.

-- Dave

