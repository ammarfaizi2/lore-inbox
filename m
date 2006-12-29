Return-Path: <linux-kernel-owner+w=401wt.eu-S965162AbWL2VJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWL2VJx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 16:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWL2VJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 16:09:53 -0500
Received: from main.gmane.org ([80.91.229.2]:47737 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965162AbWL2VJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 16:09:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: OpenSolaris under KVM?
Date: Fri, 29 Dec 2006 21:09:28 +0000 (UTC)
Message-ID: <loom.20061229T220455-260@post.gmane.org>
References: <c89a20770612271445q69ce84abv98d3265a1c88bfbe@mail.gmail.com> <45937DE6.2020704@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.85.149.9 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en) AppleWebKit/418.9.1 (KHTML, like Gecko) Safari/419.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi <at> argo.co.il> writes:

> 
> John Freighter wrote:
> > Has anybody succeded running OpenSolaris under KVM virtualization?
> > Before I download OS install DVD in vain...
> >
> 
> There was indeed a report (and a patch) from Michael Riepe to that 
> effect.  -rc2 should contain that patch.  Please report to kvm-devel if 
> it doesn't work.
> 


I tried installing Solaris 10 U2 with Qemu/KVM-8 on -rc2 plus 
the latest 8 kernel side KVM patches. 
It appeared to work well until about 80% in the installation 
where it got stuck after this error is dmesg -

vmwrite error: reg 6802 value 1c334000 (err 17408)
This was on a Core Duo Mac Mini.

Parag

