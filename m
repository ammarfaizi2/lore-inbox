Return-Path: <linux-kernel-owner+w=401wt.eu-S932907AbWL0EdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbWL0EdE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 23:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbWL0EdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 23:33:03 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:22005 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932907AbWL0EdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 23:33:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XIM8vtipwdswACFL+3xyNV1ZkuzFp71qIfp6gMYO5fbm46GetDa7qZpfcwrQSeA5WJcTlwnt8Ns3DsPN60X61EtnXvhBxneAS+bOPyr4YjDryUwuj69beCT1czWT7QOutc8RbUYbT1Ij0aVMxAe6Nm2eKmOdZTfN/SRVg/kXv4M=
Message-ID: <9e4733910612262033u4a9cc726s10d6719b25d81ac2@mail.gmail.com>
Date: Tue, 26 Dec 2006 23:33:00 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: BUG: scheduling while atomic, new libata code
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061226175559.e280e66e.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910612261747s4b32d6ben2e5a55f88f225edf@mail.gmail.com>
	 <20061226175559.e280e66e.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> Can you apply and test the patch here:
>   http://lkml.org/lkml/2006/12/26/62
> and let us know if that fixes the BUG, please.

I am running with the patch and haven't hit the BUG. But I wasn't
hitting it very often without the patch so it may take a while to know
if there is a difference.

-- 
Jon Smirl
jonsmirl@gmail.com
