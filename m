Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbUJ0Vgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbUJ0Vgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUJ0Vcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:32:46 -0400
Received: from mproxy.gmail.com ([216.239.56.249]:45972 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262692AbUJ0VaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:30:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AiTBETfHmGDYm4uDa2V5vSpLLQ8oA0rSMDOO0NwX73t1UrKWmhkoWIejWM7XD66r85CsZj2y5WZk73HOX995g6D/YciQk81qtD/4RzzHlWlIFoX69JmCW4Hk2Poji/zx1B6CdYZiqHQCEWVQvU3MMA5aoeAiEdRafxo4UI4Kk7o=
Message-ID: <21d7e99704102714303bb9424@mail.gmail.com>
Date: Thu, 28 Oct 2004 07:30:18 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Norbert Preining <preining@logic.at>
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041027135052.GE32199@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I don't want to start a flame war and long discussion, just want to ask
> wether this change (to _GPL) was intended, and if yes, if there is a way
> to fix nvidia kernel modules (or others) using this device management
> interface.

From:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.2/0369.html

EXPORT_SYMBOL_GPL() may only be used for new exported symbols, Linus
has spoken. I believe the phrase involved killer penguins with
chainsaws for anybody who changed existing exported interfaces. 

not sure if this applies or not to the class_simple interfaces,
probably not but just FYI....
there is no reason NV or who ever can't implement their own non-simple
class ....

Dave.
