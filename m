Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVAPLl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVAPLl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 06:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVAPLl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 06:41:27 -0500
Received: from mproxy.gmail.com ([216.239.56.242]:2113 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262482AbVAPLlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 06:41:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bdAwCKSkRgdqJl447almKTlMDQZG6lwd09ee5T2yRZXSzpagL7SeKYm7PwsWJykG1mNqqZWXqN8sxdXRrZN6T9QXidw6w4zGkVFoCmnjsd2hADvqWhqz5K8XLPrN5QlSb1xWaS5kUH1d2l6N9Sc9l/LjbHLD6mux9qwOpQ1t4SI=
Message-ID: <21d7e99705011603415d6a6bdf@mail.gmail.com>
Date: Sun, 16 Jan 2005 22:41:23 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: Helge Hafting <helgehaf@aitel.hist.no>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391050116033435e5db9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
	 <21d7e997050113130659da39c9@mail.gmail.com>
	 <20050115185712.GA17372@hh.idb.hist.no>
	 <21d7e997050116020859687c4a@mail.gmail.com>
	 <20050116105011.GA5882@hh.idb.hist.no>
	 <9e4733910501160304642f7882@mail.gmail.com>
	 <21d7e99705011603072d26727a@mail.gmail.com>
	 <9e473391050116033435e5db9c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'm fine with adding this code, but we still don't know if this is the
> cause of his problem. The debug output can determine if this really is
> the source of the problem or if it is somewhere else.
> 

I actually doubt it is this stuff.. my guess is that it is something
nasty like ACPI breaking int10 for X or something like that... it
seems a lot more subtle than the usually things that break when we
mess with the DRM :-)

Dave.
