Return-Path: <linux-kernel-owner+w=401wt.eu-S932127AbXAHIp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbXAHIp3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbXAHIp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:45:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:29123 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127AbXAHIp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:45:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=sI6YBptP9WR8hTDxN3OMWBQ1qbQuHfJ6H8ATRdKSkkWPzrP35jsHpwbFAJjF+O+LgBxyFFEY8DZTb0J4DleZkHQ+wjMLnCoa6WFldXHJDLLNa+l4U1vfAY2xyWWSSElZEAgflVJSsJaKXc5DPPCp/Gwh5dHykD9vd4sFg7eFky4=
Message-ID: <84144f020701080045x52b1b9a3u8caf8b88856ceb@mail.gmail.com>
Date: Mon, 8 Jan 2007 10:45:26 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Amit Choudhary" <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Cc: "Hua Zhong" <hzhong@gmail.com>, "Christoph Hellwig" <hch@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <810563.91187.qm@web55604.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <84144f020701080000v460a9f3aja9570e72fa457934@mail.gmail.com>
	 <810563.91187.qm@web55604.mail.re4.yahoo.com>
X-Google-Sender-Auth: cde2afff3c739f79
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 1/8/07, Amit Choudhary <amit2030@yahoo.com> wrote:
> Man, doesn't make sense to me.

Well, man, double-free is a programming error and papering over it
with NULL initializations bloats the kernel and makes the code
confusing.

Clear enough for you?
