Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753940AbWKHCsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbWKHCsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbWKHCsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:48:00 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:30392 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753940AbWKHCr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:47:58 -0500
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Paul Menage <menage@google.com>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061107120246.4b6b3f0b.pj@sgi.com>
References: <20061030031531.8c671815.pj@sgi.com>
	 <20061030123652.d1574176.pj@sgi.com>
	 <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	 <20061031115342.GB9588@in.ibm.com>
	 <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	 <20061101172540.GA8904@in.ibm.com>
	 <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	 <20061106124948.GA3027@in.ibm.com>
	 <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	 <20061107104118.f02a1114.pj@sgi.com>
	 <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
	 <20061107120246.4b6b3f0b.pj@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Tue, 07 Nov 2006 18:47:54 -0800
Message-Id: <1162954075.12419.583.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 12:02 -0800, Paul Jackson wrote:
> Paul M wrote:
> > I think it's better to treat resource groups as a common framework for
> > resource controllers, rather than a resource controller itself.
> 
> You could well be right here - I was just using resource groups
> as another good example of a controller.  I'll let others decide
> if that's one or several controllers.

	At various stages different controllers were available with the core
patches or separately. The numtasks, cpu, io, socket accept queue, and
memory controllers were available for early CKRM patches. More recently
(April 2006) numtasks, cpu, and memory controllers were available for
Resource Groups.

	So I'd say "several".

Cheers,
	-Matt Helsley

