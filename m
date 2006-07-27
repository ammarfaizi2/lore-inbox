Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWG0SOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWG0SOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWG0SOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:14:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:35425 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751909AbWG0SOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:14:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hxOVdMZ38ga90bDxvDrJEc4QQa90UpD+JsA0MIQFoPy5OnaUvz4UJtYXGDEatJ3FtM6bgiN9yKoartpfiJUN0tGgP9qBJgakwd9W5Lb+E6K5kPXVh5i9BCoESQ7NA8ptxlf29MyEhpVzzCH4Bs4GmrPErU14P+2t4uLFVVz/m2s=
Message-ID: <bda6d13a0607271114xc3ece61i27858b4c07501313@mail.gmail.com>
Date: Thu, 27 Jul 2006 11:14:17 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: O_CAREFUL flag to disable open() side effects
In-Reply-To: <44C8FFFE.3010402@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>
	 <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>
	 <1154021616.13509.68.camel@localhost.localdomain>
	 <44C8F8E3.1070306@zytor.com>
	 <1154023516.13509.72.camel@localhost.localdomain>
	 <44C8FFFE.3010402@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or say make O_NONE able to open symbolic links (for fcalls such as
fchown/fchmod/fstat).

I would also suggest that no permission bits be requred to open a file
with O_NONE, but that might be a very bad idea.
