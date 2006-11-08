Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161720AbWKHTZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161720AbWKHTZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161722AbWKHTZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:25:30 -0500
Received: from zrtps0kn.nortel.com ([47.140.192.55]:49899 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP
	id S1161720AbWKHTZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:25:30 -0500
Message-ID: <45522F1E.8040002@nortel.com>
Date: Wed, 08 Nov 2006 13:25:18 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Paul Jackson <pj@sgi.com>, Paul Menage <menage@google.com>, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061031115342.GB9588@in.ibm.com> <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com> <20061101172540.GA8904@in.ibm.com> <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com> <20061106124948.GA3027@in.ibm.com> <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com> <20061107104118.f02a1114.pj@sgi.com> <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com> <6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com> <20061107191518.c094ce1a.pj@sgi.com> <20061108051257.GB2964@in.ibm.com>
In-Reply-To: <20061108051257.GB2964@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2006 19:25:22.0666 (UTC) FILETIME=[A2899CA0:01C7036B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

> As was discussed in a previous thread, having a 'threads' file also will
> be good.
> 
> 	http://lkml.org/lkml/2006/11/1/386

> Writing to 'tasks' file will move that single thread to the new
> container. Writing to 'threads' file will move all the threads of the
> process into the new container.

That's exactly backwards to the proposal that you linked to.

Chris
