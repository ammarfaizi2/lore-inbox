Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbRFMJLW>; Wed, 13 Jun 2001 05:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFMJLM>; Wed, 13 Jun 2001 05:11:12 -0400
Received: from t2.redhat.com ([199.183.24.243]:4852 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S262616AbRFMJK7>; Wed, 13 Jun 2001 05:10:59 -0400
Message-ID: <3B272E20.79E5472F@redhat.com>
Date: Wed, 13 Jun 2001 10:10:56 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@cambridge.redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-11.3smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: craigl@promise.com, linux-kernel@vger.kernel.org
Subject: Re: [craigl@promise.com: Getting A Patch Into The Kernel] (fwd)
In-Reply-To: <Pine.LNX.4.10.10106122307580.9287-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Craig Lyons,

> Hello,
> 
> My name is Craig Lyons and I am the marketing manager at Promise Technology.
> We have a question and are hoping you can point us in the right direction.
> In the 2.4 kernel there is support for some of our products (Ultra 66, Ultra
> 100, etc.). As you may or may not know, our Ultra family of controllers
> (which are just standard IDE controllers and do not have RAID) use the same
> ASIC on them as our FastTrak RAID controllers do. The 2.4 kernel will
> recognize our Ultra family of controllers, but there is a problem in that a
> FastTrak will not be recognized as a FastTrak, but as an Ultra.
> Consequently, the array on the FastTrak is not recognized as an array, but
> instead each disk is seen individually, and the users data cannot be
> properly accessed. 


This is not correct. Kernel 2.4.5-ac13 and later have a driver to
support the Fasttrak 
raid system. I wish Promise was more helpful during the development of
this driver,
as it is currently developed fully independent and without any help /
support or even
acknowledgement of Promise. As a result, not yet all RAID modes and
configurations are
fully supported. 

Greetings,   
   Arjan van de Ven
