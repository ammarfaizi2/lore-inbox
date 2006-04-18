Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWDRTby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWDRTby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWDRTby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:31:54 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:30854 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S932280AbWDRTbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:31:53 -0400
Message-ID: <44453E7B.1090009@novell.com>
Date: Tue, 18 Apr 2006 12:31:07 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: Gerrit Huizenga <gh@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <1145381250.19997.23.camel@jackjack.columbia.tresys.com>
In-Reply-To: <1145381250.19997.23.camel@jackjack.columbia.tresys.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karl MacMillan wrote:
> Which is one reason why SELinux has types (equivalence classes) - it
> makes it possible to group large numbers of applications or resources
> into the same security category. The targeted policy that ships with
> RHEL / Fedora shows how this works in practice.
>   
AppArmor (then called "SubDomain") showed how this worked in practice
years before the Targeted Policy came along. The Targeted Policy
implements an approximation to the AppArmor security model, but does it
with domains and types instead of path names, imposing a substantial
cost in ease-of-use on the user.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

