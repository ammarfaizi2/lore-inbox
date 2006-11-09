Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424100AbWKIQkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424100AbWKIQkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424104AbWKIQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:40:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24785 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424100AbWKIQkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:40:31 -0500
Date: Thu, 9 Nov 2006 11:39:22 -0500
From: Don Zickus <dzickus@redhat.com>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: ebiederm@xmission.com, Fastboot mailing list <fastboot@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Message-ID: <20061109163922.GE5622@redhat.com>
References: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 08:07:22PM -0800, Lu, Yinghai wrote:
> Eric,
> 
> I got "Invalid memory segment 0x100000 - ..."
> using kexec latest kernel...

I usually see this when people forget to add the "crashkernel=X@Y" into
their /etc/grub.conf kernel command line.  Where X and Y are arch
specific.

Cheers,
Don

