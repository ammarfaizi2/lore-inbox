Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312033AbSCQNzw>; Sun, 17 Mar 2002 08:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312035AbSCQNzn>; Sun, 17 Mar 2002 08:55:43 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:24825 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312033AbSCQNz3>; Sun, 17 Mar 2002 08:55:29 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1016305054.19498.13.camel@sonja> 
In-Reply-To: <1016305054.19498.13.camel@sonja>  <20020316061535.GA16653@krispykreme> <730219199.1016271418@[10.10.2.3]> 
To: Daniel Egger <degger@fhm.edu>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] 7.52 second kernel compile 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Mar 2002 13:54:40 +0000
Message-ID: <7874.1016373280@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


degger@fhm.edu said:
>  Interestingly -pipe doesn't give any measurable performance increases
> or even leads to a minor decrease in compile speed in my latest tests
> on bigger projects like the linux kernel or GIMP.

I believe that newer versions of GCC have a builtin preprocessor, and -pipe 
forces them to use the old, slower, external cpp. 

--
dwmw2


