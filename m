Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSJJQdO>; Thu, 10 Oct 2002 12:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbSJJQdO>; Thu, 10 Oct 2002 12:33:14 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:35730 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261724AbSJJQdN>;
	Thu, 10 Oct 2002 12:33:13 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Grothe <dave@gcom.com>
Date: Thu, 10 Oct 2002 18:38:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Cc: linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       davem@redhat.com, bidulock@openss7.org
X-mailer: Pegasus Mail v3.50
Message-ID: <4386E3211F1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Oct 02 at 11:32, David Grothe wrote:

> Previous patch was "better" but not correct.  How about this? (changed 
> return 0 to return ret).

Yes, it's ok with me. You can still do
register(NULL, notNULL);
register(notNULL, NULL);
without trigerring any error, but maybe that it can be called feature.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
