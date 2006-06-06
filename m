Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWFFWDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWFFWDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWFFWDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:03:03 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:5904 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751142AbWFFWDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:03:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mdBmegmB3OTxfmPNOqCOYX8I5PeHSYrqt/ZPjeRWycnmGIw/An+xuWaGRBNJiqwHigdn0Gz563CtehCDc1aFcTzAiahOVVNx0/uC+AbGjKGfzZ9uE+amb7ruNyvrTgbqJ9amMOwq2DLuw+zFXI584Oo7Z3V1L82EcnANf4akV+8=
Message-ID: <3faf05680606061502q28501343yb3a91dbda3c423b6@mail.gmail.com>
Date: Wed, 7 Jun 2006 03:32:58 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Quick close of all the open files.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606062156.k56LuWFD001871@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com>
	 <200606062156.k56LuWFD001871@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For bonus points, how did you verify that all the open files were closed?
>
I checked as follows I did printf("lowest fd = %d",fileno(tmpfile()));
it prints 3

> (Hint - what does that fp->_chain = stderr *really* do? ;)
>
>
>
