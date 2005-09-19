Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVISGzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVISGzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVISGzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:55:46 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:30903 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932341AbVISGzp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:55:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ePrw4Fjr62mgJL4HX6s7pDyJcX/iCXIm3ZyHctk0FY40SotktqAROnHMroicCSIbLn3FchiYXSUZFUa4yPXPs+EzgBUHMiVxP0Hv40DjRf05yMocsvP5QdR1L3RXQY+aybuTgeAyzDBRLxgJCkKeqn8HU8X7hLbeOrNpWVYWLLY=
Message-ID: <2cd57c9005091823551e49bc23@mail.gmail.com>
Date: Mon, 19 Sep 2005 14:55:44 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: Al Boldi <a1426z@gawab.com>
Subject: Re: Fork capture
Cc: linux-assembly@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-smp@vger.kernel.org
In-Reply-To: <200509181748.40029.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509181748.40029.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/05, Al Boldi <a1426z@gawab.com> wrote:
> 
> Is there a way to capture a process-fork?
> 
> Something like:
> process/kModule A monitors procs for forking, captures it and manages further
> processing.

Look at the fork_connector patch.
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
