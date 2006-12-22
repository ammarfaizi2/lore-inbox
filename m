Return-Path: <linux-kernel-owner+w=401wt.eu-S1945951AbWLVF4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945951AbWLVF4t (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 00:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945953AbWLVF4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 00:56:49 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:61241 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945951AbWLVF4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 00:56:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A82Wy2CiSGvjgN8MOx73oH8U7pOIdVvhcUp2QgZWlKVM/aa6djg8uH9Ebon/ZiVqaSNRj9d/wIvIXc/DqoIJI59QZNWr4eW4GsMzPuPlebqUOy3AJv8+TWl5EQc+9zspxrITAl4tfAtDxn8ohH4gSx9mf50j4YY/l+wAZZSX3Ek=
Message-ID: <652016d30612212156g604d0d15y7fbd27c01e2aab1e@mail.gmail.com>
Date: Fri, 22 Dec 2006 11:41:47 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: "Bhanu Kalyan Chetlapalli" <chbhanukalyan@gmail.com>
Subject: Re: Linux disk performance.
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <7d15175e0612212139p4fc2fd27x7acb3473701b2c35@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
	 <1166431020.3365.931.camel@laptopd505.fenrus.org>
	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
	 <20061218130702.GA14984@gateway.home>
	 <652016d30612182222h7fde4ea5jbc0927c8ebeae76a@mail.gmail.com>
	 <458788D7.2070107@yahoo.com.au>
	 <652016d30612200317i6d33d097xe55971750e83cd97@mail.gmail.com>
	 <7d15175e0612211614y3ce090fcn38cbcaced76b1024@mail.gmail.com>
	 <652016d30612212130v433b4e70uc2148278c7ee7198@mail.gmail.com>
	 <7d15175e0612212139p4fc2fd27x7acb3473701b2c35@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, Bhanu Kalyan Chetlapalli <chbhanukalyan@gmail.com> wrote:
> >
> > Thanks  for the suggestion but the performance was terrible when write
> > cache was disabled.
>
> Performance degradation is expected. But the point is - did the
> anomaly, that you have pointed out, go away? Because if it did, then
> it is the disk cache which is causing the issue, and you will have to
> live with it. Else you will have to look elsewhere.

oops, sorry for incomplete answer.
Actually i did not tested thoroughly but my initial tests showed some
bumps and serious performance degradation. But anyway there was still
some bumps... :(

(sequence)(channel)(write time in microseconds)
0	       0	6366
0	       1	9949
0	       2	10125
0	       3	10165
0	       4	11043
0	       5	10129
0	       6	10089
0	       7	10165
0	       8	71572
0	       9	9882
0	       10	8105
0	       11	10085


-- 
---------------------------------------------------------------
regards
Manish Regmi

---------------------------------------------------------------
UNIX without a C Compiler is like eating Spaghetti with your mouth
sewn shut. It just doesn't make sense.
