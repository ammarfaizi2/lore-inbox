Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754135AbWKHEPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbWKHEPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 23:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbWKHEPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 23:15:41 -0500
Received: from smtp-out.google.com ([216.239.45.12]:64924 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1754135AbWKHEPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 23:15:40 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=oJwNlW38q7kJCQm/6AImmh8O3dxcrBQBhNARzqxUTyffug8XdhXjdNuuu2eW0dD//
	8VNpCajWg9SDVxhfqBHOA==
Message-ID: <6599ad830611072015g48a7013r3e3aed1bf22e905d@mail.gmail.com>
Date: Tue, 7 Nov 2006 20:15:31 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061107191518.c094ce1a.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030031531.8c671815.pj@sgi.com>
	 <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	 <20061101172540.GA8904@in.ibm.com>
	 <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	 <20061106124948.GA3027@in.ibm.com>
	 <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	 <20061107104118.f02a1114.pj@sgi.com>
	 <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
	 <6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com>
	 <20061107191518.c094ce1a.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Paul Jackson <pj@sgi.com> wrote:
> Paul M wrote:
> > One drawback to this that I can see is the following:
> >
> > - suppose you mount a containerfs with controllers cpuset and cpu, and
> > create some nodes, and then unmount it, what happens? do the resource
> > nodes stick around still?
>
> Sorry - I let interfaces get confused with objects and operations.
>
> Let me back up a step.  I think I have beat on your proposal enough
> to translate it into the more abstract terms that I prefer using when
> detemining objects, operations and semantics.
>
> It goes like this ... grab a cup of coffee.
>

That's pretty much what I was envisioning, except for the fact that I
was trying to fit the controller/container bindings into the same
mount/umount interface. I still think that might be possible with
judicious use of mount options, but if not we should probably just use
configfs or something like that as a binding API.

Paul
