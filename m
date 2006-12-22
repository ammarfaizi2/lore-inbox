Return-Path: <linux-kernel-owner+w=401wt.eu-S1161125AbWLVJ5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWLVJ5e (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 04:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWLVJ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 04:57:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:22470 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161116AbWLVJ5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 04:57:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bVh1RKTpITZi0UocgHXZ/ENDO6bsT/GYp7OTaCccgpygNUBFJrFEW3n2J1CyuR7wyYCdJes06DXtrHYLBBIS+iWUoNbFnGu4aAurfRHoybHYm9JDhWvCr4q+IwHs15lM0mKruN/g6RyjDPKF7oH09JlUjkiOGl7QVL2VJXtEfeg=
Message-ID: <cda58cb80612220157q5433c346pccd06b8b7cbaadba@mail.gmail.com>
Date: Fri, 22 Dec 2006 10:57:31 +0100
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.19 1/1] fbdev,mm: hecuba/E-Ink fbdev driver v2
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <cda58cb80612200050h6def9866nf1798753da9d842d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612111046.kBBAkV8Y029087@localhost.localdomain>
	 <457D895D.4010500@innova-card.com>
	 <45a44e480612111554j1450f35ub4d9932e5cd32d4@mail.gmail.com>
	 <cda58cb80612130038x6b81a00dv813d10726d495eda@mail.gmail.com>
	 <45a44e480612162025n5d7c77bdkc825e94f1fb37904@mail.gmail.com>
	 <cda58cb80612200050h6def9866nf1798753da9d842d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:

>     - when mmaping your frame buffer , be sure that the virtual
>       address returned by mmap() to the application shares the
>       same cache lines than the ones the kernel
>       is using.

Well thinking more about it, this wouldn't work for all cache types.
For example, if your cache is not a direct maped one, this workaround
won't work. So this is definitely not a portable solution.

-- 
               Franck
