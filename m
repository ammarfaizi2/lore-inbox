Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966263AbWK2ISU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966263AbWK2ISU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966279AbWK2ISU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:18:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:46295 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966263AbWK2IST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:18:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JJEy85duBHfrbYeGXezriDDIlaARZNTGHTXcEjolwfg6pDHCDav1xaIHKlEaOpbXP/og3dVrwM8Z3JLVYcavlFf2wewjTZW+Hr9Vbrpho6oXX81UmeI6AM6a4vGAK81t++9zaKiYdec4hI3T+bxHv6WsLIyAR98yi9ipAUGh0VI=
Message-ID: <ac8af0be0611290018y70c68a66r5a3199f08e6417d5@mail.gmail.com>
Date: Wed, 29 Nov 2006 00:18:18 -0800
From: "Zhao Forrest" <forrest.zhao@gmail.com>
To: "Andi Kleen" <ak@suse.de>, bunk@stusta.de
Subject: Re: A commit between 2.6.16.4 and 2.6.16.5 failed crashme
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/06, Andi Kleen <ak@suse.de> wrote:
>
> > I first need to contact the author of test case if we could send the
> > test case to open source. The test case is called "crashme",
>
> Is that the classical crashme as found in LTP or an enhanced one?
> Do you run it in a special way? Is the crash reproducible?
>
> We normally run crashme regularly as part of LTP, Cerberus etc.
> so at least any obvious bugs should in theory be caught.
>

Let me change the subject of this thread.
I just read our private version of crashme. It's based on crashme
version 2.4 and add some logging capability, no other enhancement. So
it should be the same as crashme in LTP.

It is solidly reproducible within 3 minutes of running crashme.

The current status is: we know it's a commit between 2.6.16.4 and
2.6.16.5 that introduce this bug.

Our network is very slow(only 5-6K/second). So we'll start the
git-bisect tomorrow after finishing downloading the 2.6.16 stable git
tree.

Thanks,
Forrest
