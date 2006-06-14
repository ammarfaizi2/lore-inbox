Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWFNDtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWFNDtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 23:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWFNDto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 23:49:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:24582 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751130AbWFNDto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 23:49:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FDG8DYpCJWo4fhJwo5SmjaqxM/68ARYoFayVvs06bM4mLPhb+xPBTR81ML0II7uS8QkVxZHm+cEEUnNh8qcGB8k7o3ZppZKPMqN2Y6qcHgJUQ+Da86nGqAxBfL8Bxe44Bl+5dc7odxqmDnUS/q9W0a8CaA0gU6Jx1CnUjyORUh4=
Message-ID: <3aa654a40606132049u43f81ee1m263ee15666246152@mail.gmail.com>
Date: Tue, 13 Jun 2006 20:49:43 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Russell Whitaker" <russ@ashlandhome.net>
Subject: Re: 2.6.16.19 + gcc-4.1.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/06, Russell Whitaker <russ@ashlandhome.net> wrote:
> Then, after mrproper, rebuilt with gcc-4.1.1, no other changes.
>    compiles ok, installs ok. But, when attempting to load a module, get
>    the following message:  version magic '2.6.16.19via K6 gcc-4.1',
>    should be '2.6.16.19via 486 gcc-3.3'

You may have forgotten to "make modules modules_install"
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
