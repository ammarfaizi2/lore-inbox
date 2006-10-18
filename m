Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWJRBWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWJRBWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 21:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWJRBWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 21:22:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:25965 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751219AbWJRBWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 21:22:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W00Yd1+zRe0gxu+b0utpBVsc1m1Z+9CcvDSLjcDJhPJxtkhR76+lY7NTTU10FtSt0eDDmnFHXzJp+9zFpsSE8/ukfNkqMTk90p64rZ2ZrpxkCM3AgHMZkFR/m1yg1/V+m941mjKE7qHO4Rxj/Y7iGKPNYvU+4s4dImZuhdPavoE=
Message-ID: <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com>
Date: Wed, 18 Oct 2006 10:22:44 +0900
From: "Mohit Katiyar" <katiyar.mohit@gmail.com>
To: "Frank van Maarseveen" <frankvm@frankvm.com>
Subject: Re: NFS inconsistent behaviour
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061016093904.GA13866@janus>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
	 <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com>
	 <20061016084656.GA13292@janus>
	 <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
	 <20061016093904.GA13866@janus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Frank I couldnt check your response due to non availability of machine.
I checked it today and when i issued the netstat -t ,I could see a lot
of tcp connections in TIME_WAIT state.
Is this a normal behaviour? So we cannot mount and umount infinitely
with tcp option? Why there are so many connections in waiting state?
These all questions pop up suddenly when such things happen
Any help would be great

Thanks
Mohit

On 10/16/06, Frank van Maarseveen <frankvm@frankvm.com> wrote:
> On Mon, Oct 16, 2006 at 06:35:24PM +0900, Mohit Katiyar wrote:
> > Hi,
> > But I think unmounting will free the sockets.
>
> Try "netstat -t", when the problem occurs. It will probably
> show a lot tcp connections in state TIME_WAIT.
>
> --
> Frank
>
