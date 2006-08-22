Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWHVRJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWHVRJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWHVRJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:09:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:5140 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932202AbWHVRJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:09:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OxmqjydglMoR+l/6e+DgwyrTHYmGI2gPv8RxrK9V6aqCb5yoe5fNtpyehdHh5wi/5ag7+p8QsXShiO0h1AThWTHZox8N6hvNiT+4J5wzKDnlyJ5IjfX5tIxVEyzarTyVjepE0583SG9pbSw8/CEEFLHBLD5XkQyiiYOHnk3zDW4=
Message-ID: <b3f268590608221009q46f66a67w343bd75ab24d9f22@mail.gmail.com>
Date: Tue, 22 Aug 2006 19:09:45 +0200
From: "Jari Sundell" <sundell.software@gmail.com>
To: netdev <netdev@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
In-Reply-To: <b3f268590608220957g43a16d6bmde8a542f8ad8710b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy>
	 <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy>
	 <b3f268590608220957g43a16d6bmde8a542f8ad8710b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to mention the name used causes (at least me) some confusion with
BSD's kqueue implementation. Skimming over the patches it actually
looks somewhat like kqueue with the more interesting features removed,
like the ability to pass the filter changes simultaneously with
polling.

Maybe this is a topic that will singe my fur, but what is wrong with
the kqueue API? Will I really have to implement support for yet
another event API in my program.

Rakshasa
