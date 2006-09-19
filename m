Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752087AbWISW4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbWISW4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbWISW4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:56:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:33118 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752087AbWISW4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:56:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=J9KqF0d0PGw9yD7IOjSkh1miMwrlNRlVzpzSKYtYRCpAEgeKBAniRKJ92BYTdkzTCl1EHgB/zpsHDo7lGzPJgGkxnrg6BO8cJzdsZzQ6soH+4HhsCcCmbmFQrkUIMvNf/1Qf42EHyQWM3+BSHzhAfJpU+lhpKO5Zyi+lSv+ESGc=
Message-ID: <12c511ca0609191555q2bfb934aha4cfc0068c1ccd9a@mail.gmail.com>
Date: Tue, 19 Sep 2006 15:55:58 -0700
From: "Tony Luck" <tony.luck@intel.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: Efficient Use of the Page Cache with 64 KB Pages
Cc: "Sandeep Kumar" <sandeepksinha@gmail.com>, linux-kernel@vger.kernel.org,
       shaggy@austin.ibm.com
In-Reply-To: <Pine.LNX.4.64.0609191136580.6460@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <37d33d830609150150v30dc32en57f8c5e43c30aef3@mail.gmail.com>
	 <Pine.LNX.4.64.0609191136580.6460@schroedinger.engr.sgi.com>
X-Google-Sender-Auth: b63fc36d3523d946
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/06, Christoph Lameter <clameter@sgi.com> wrote:
> IA64 has supported 64k page size from the beginning. Since some
> years before the end of the last decade. It is only the hardware
> limitations on IA32 that hold us back.

But memory usage with a 64K page size can get out of hand (especially
if you have an application that uses a lot of small files).  Dave Kleikamp's
tail pages would help make 64K page size more generally palatable.

-Tony

----
New yarn store in Sunnyvale opens October 14th. http://www.purlescenceyarns.com
